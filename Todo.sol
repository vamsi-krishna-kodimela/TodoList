// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract ToDO {
    struct Task {
        uint256 id;
        string title;
        bool completed;
    }
    struct User {
        uint256 taskCount;
        mapping(uint256 => Task) tasks;
    }

    mapping(address => User) private users;

    function createTask(string memory _title) public {
        address addr = msg.sender;
        User storage _user = users[addr];
        Task memory _task = Task(_user.taskCount, _title, false);
        _user.tasks[_user.taskCount] = _task;
        _user.taskCount++;
    }

    function getTasks() public view returns (Task[] memory) {
        address addr = msg.sender;
        User storage _user = users[addr];
        uint256 _taskCount = _user.taskCount;
        Task[] memory tasksList = new Task[](_taskCount);
        for (uint256 i = 0; i < _taskCount; i++) {
            tasksList[i] = _user.tasks[i];
        }
        return tasksList;
    }

    function toggleTask(uint256 _id) public {
        address addr = msg.sender;
        User storage _user = users[addr];
        require(_user.taskCount >= _id);
        Task memory _task = _user.tasks[_id];
        _task.completed = !_task.completed;
        _user.tasks[_id] = _task;
    }
}
