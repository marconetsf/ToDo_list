import 'package:flutter/src/services/text_input.dart';
import 'package:todo_list/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list/app/services/tasks/tasks_service.dart';

class TaskCreateController extends DefaultChangeNotifier {
  final TasksService _tasksService;
  DateTime? _selectedDate;

  TaskCreateController({required TasksService tasksService})
    : _tasksService = tasksService;

  set selectedDate(DateTime? selectedDate) {
    resetState();
    _selectedDate = selectedDate;
    notifyListeners();
  }

  DateTime? get selectedDate => _selectedDate;

  Future<void> save(String description) async {
    try {
      showLoadingAndResetState();
      notifyListeners();
      if (_selectedDate != null) {
        await _tasksService.save(_selectedDate!, description);
        success();
      } else {
        setError('Data da task não selecionada');
      }
    } catch (e, s) {
      setError('Erro ao cadastrar task');
      print(e);
      print(s);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  Future<void> deleteById(int id) async {
    try{
      showLoadingAndResetState();
      notifyListeners();

      await _tasksService.deleteTaskById(id);
    } catch (e, s){

    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
