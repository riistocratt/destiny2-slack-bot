// Copyright (c) 2017 P.Y. Laligand

import 'package:heroku_slack_bot/heroku_slack_bot.dart';
import 'package:logging/logging.dart';

import '../lib/commands/online_handler.dart';
import '../lib/commands/roster_handler.dart';
import '../lib/middleware/config_provider.dart';

const String BOT_CONFIG = 'BOT_CONFIG';

class Config extends ServerConfig {
  @override
  String get name => 'Destiny2SlackBot';

  @override
  List<String> get environmentVariables => const [BOT_CONFIG];

  @override
  Map<String, SlackCommandHandler> loadCommands(Map<String, String> env) => {
        'online': new OnlineHandler(),
        'roster': new RosterHandler(),
      };

  @override
  List<Middleware> loadMiddleware(Map<String, String> env) => [
        ConfigProvider.get(env[BOT_CONFIG]),
      ];

  @override
  List<String> get stallingMessages => [
        'Kindly don\'t delete this query...',
        'Contacting Destiny servers... still...',
        'The Cryptarchs are on it...',
      ];
}

main() async {
  // Disable Dartson's annoying logs.
  hierarchicalLoggingEnabled = true;
  new Logger('dartson')..level = Level.OFF;

  await runServer(new Config());
}
