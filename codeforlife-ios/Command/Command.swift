//
// Created by Thomas CASSANY on 17/06/15.
// Copyright (c) 2015 Ocado. All rights reserved.
//

import Foundation

protocol Command {
    func excute<CommandParameter, Response>(commandParameter: CommandParameter) -> Response;
}
