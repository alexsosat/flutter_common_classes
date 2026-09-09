import 'package:flutter/material.dart';
import 'package:flutter_common_classes/flutter_common_classes.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Demonstrates [SecureStorageService] configured with each
/// [SecurityAccessLevel] option side by side.
class SecureStorageExamplePage extends StatelessWidget {
  const SecureStorageExamplePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("Secure storage example")),
    body: ListView(
      padding: EdgeInsets.all(16),
      children: [
        _SecureStorageSection(level: SecurityAccessLevel.none),
        Divider(height: 32),
        _SecureStorageSection(level: SecurityAccessLevel.device),
        Divider(height: 32),
        _SecureStorageSection(level: SecurityAccessLevel.biometric),
      ],
    ),
  );
}

class _SecureStorageSection extends StatefulWidget {
  const _SecureStorageSection({required this.level});

  final SecurityAccessLevel level;

  @override
  State<_SecureStorageSection> createState() => _SecureStorageSectionState();
}

class _SecureStorageSectionState extends State<_SecureStorageSection> {
  late final _controller = _SecureStorageExampleController(widget.level);
  final _inputController = TextEditingController();
  String? _storedValue;
  String? _error;

  Future<void> _save() async {
    setState(() => _error = null);
    try {
      await _controller.setValue(_inputController.text);
    } catch (e) {
      setState(() => _error = e.toString());
    }
  }

  Future<void> _load() async {
    setState(() => _error = null);
    try {
      final value = await _controller.getValue();
      setState(() => _storedValue = value);
    } catch (e) {
      setState(() => _error = e.toString());
    }
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        widget.level.name,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      const SizedBox(height: 8),
      TextField(
        controller: _inputController,
        decoration: const InputDecoration(labelText: "Value to store"),
      ),
      const SizedBox(height: 8),
      Row(
        children: [
          ElevatedButton(onPressed: _save, child: const Text("Save")),
          const SizedBox(width: 8),
          OutlinedButton(onPressed: _load, child: const Text("Load")),
        ],
      ),
      const SizedBox(height: 8),
      Text("Stored value: ${_storedValue ?? '-'}"),
      if (_error != null)
        Text(_error!, style: const TextStyle(color: Colors.red)),
    ],
  );
}

/// Wraps a [FlutterSecureStorage] instance configured for a specific
/// [SecurityAccessLevel], exposing a getter/setter pair for the example
/// value stored under it.
class _SecureStorageExampleController {
  _SecureStorageExampleController(this.level)
    : _storage = SecureStorageService.initializeStorage(
        storageName: level.name,
        unlockOption: level,
      );

  final SecurityAccessLevel level;
  final FlutterSecureStorage _storage;

  static const _key = "example_value";

  /// Setter: persists [value] under the example key for this access level.
  Future<void> setValue(String value) =>
      _storage.write(key: _key, value: value);

  /// Getter: reads the persisted example value, or null if unset.
  Future<String?> getValue() => _storage.read(key: _key);
}
