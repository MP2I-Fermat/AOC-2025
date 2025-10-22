import 'package:jaspr/jaspr.dart';

class Documentation extends StatelessComponent {
  const Documentation({super.key});

  @override
  Component build(BuildContext context) {
    return div(
      styles: Styles(
        display: .block,
        width: .percent(100),
        height: .percent(100),
        overflow: .only(y: Overflow.scroll),
      ),

      [
        div(styles: Styles(padding: .all(.pixels(8))), [
          text(
            '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam dolor sem, volutpat auctor tristique ut, lobortis id eros. Mauris gravida felis consectetur vestibulum sodales. Curabitur sapien tortor, mattis eget dignissim in, fermentum a tortor. Morbi at nunc mollis, pretium diam vel, ultricies metus. Integer vitae nulla in dolor aliquam auctor efficitur quis erat. Nunc malesuada elit vel molestie pellentesque. Curabitur non finibus neque. Maecenas vitae convallis massa, et suscipit nisi. Phasellus ac ante vitae nisi sodales imperdiet. Donec pellentesque vitae leo ut mollis. Proin sed tortor enim. Suspendisse finibus nulla in sagittis tincidunt. Aliquam in metus vitae leo iaculis lobortis a quis lorem. Phasellus in leo euismod, viverra est eget, elementum sapien. Nunc rhoncus ex in turpis pellentesque ultrices. Praesent scelerisque augue non viverra tempus.

Nullam accumsan tellus at est vestibulum, consequat tempor dui facilisis. Aliquam erat volutpat. Nam nisl libero, scelerisque ut libero vel, efficitur lobortis sem. Pellentesque hendrerit massa velit, ut semper ex egestas vitae. Etiam tempus sapien sit amet feugiat pharetra. Quisque ullamcorper consectetur elit. Praesent vel tellus ut leo convallis dignissim. Vestibulum et nunc libero. Cras nunc nisl, condimentum et aliquam in, egestas et est. Vestibulum sagittis sapien non est pulvinar euismod. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi laoreet dui vitae metus semper, sit amet dictum quam vestibulum.

Sed sit amet accumsan enim. Quisque ante nibh, egestas et mauris sed, sagittis sagittis est. Mauris mattis lacus id nisl aliquet rutrum. Aenean congue metus ac efficitur convallis. Donec tincidunt augue vitae nibh interdum feugiat. Morbi vel magna eget enim faucibus vestibulum. Nam rhoncus urna eget nisi mollis, eu commodo leo commodo. Suspendisse potenti. Cras ornare pharetra dolor eget scelerisque. Phasellus rutrum molestie laoreet. Duis metus erat, lobortis ac efficitur sit amet, fringilla a est. Mauris condimentum interdum cursus. Etiam consectetur, arcu congue mattis vestibulum, dolor arcu tempus diam, vitae suscipit ligula nulla quis nisl. Praesent felis velit, scelerisque in ex a, faucibus porttitor ex. Nam tincidunt libero ac turpis finibus gravida. Maecenas egestas erat id felis ornare pulvinar.

Cras eget auctor ex. Donec placerat hendrerit augue fringilla tincidunt. Phasellus tincidunt, libero in accumsan venenatis, justo lorem ultricies risus, ut vehicula arcu mauris condimentum tellus. Nam id maximus mi. Vestibulum tortor est, vestibulum in ex quis, interdum pellentesque lorem. Nulla et tempor ante. Phasellus ut ante nec tortor interdum egestas nec a diam. Proin rhoncus enim hendrerit faucibus suscipit. Nullam dapibus, odio vel suscipit sagittis, nibh nunc bibendum ligula, ornare luctus nunc dui in massa. Donec pharetra elit ex, at vestibulum mauris lobortis sed.

Vivamus et efficitur justo. Praesent mattis egestas mollis. Nulla semper nisi nec semper mollis. Aliquam fringilla, sem sit amet vehicula porttitor, massa quam sagittis nulla, eget convallis urna sem at sapien. Morbi luctus metus ac venenatis pulvinar. Suspendisse varius massa ac neque mattis, at viverra odio fringilla. Nunc gravida massa mauris, non imperdiet nunc egestas vitae. Curabitur neque odio, porta et nulla nec, vehicula consequat urna. Nulla ligula magna, accumsan vel pretium a, eleifend eget ex. Morbi at fermentum arcu. Nulla facilisi. Donec elementum tristique eleifend. Ut quis pharetra dui. Duis pellentesque magna sed euismod pellentesque.

Nullam fermentum nisi ultricies tempus pellentesque. Nunc consequat eleifend dolor, in ornare augue rhoncus quis. Nullam vulputate nisl vitae tellus rutrum, sed lacinia augue semper. Quisque euismod ultrices mi et sollicitudin. Sed vitae tincidunt lectus. Maecenas eget tincidunt nunc, eu aliquet nibh. Phasellus laoreet lacinia est a ultrices.

Nam nisl arcu, cursus vitae placerat sed, ultrices ac lorem. Vivamus feugiat fringilla nisi ac rutrum. Nam ultricies et enim vitae aliquam. Aenean egestas elit non interdum euismod. Nam sit amet fermentum dolor. Nulla dictum dui eget consequat ornare. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nulla ac velit sit amet risus volutpat vulputate at id metus.

Duis nec ante id metus venenatis scelerisque dapibus vitae magna. Vestibulum id pellentesque sem. Nullam bibendum, dolor sed euismod porta, eros augue tincidunt est, a tempus massa tellus nec nibh. In quis porta elit. Suspendisse congue suscipit elit mattis eleifend. Praesent magna quam, mollis ut suscipit non, tempor at mauris. Donec placerat, metus quis consectetur consequat, nulla massa euismod orci, congue porttitor felis mauris vitae odio. In in nulla sit amet nisl feugiat pellentesque ut eget lorem. Quisque fringilla ultrices felis, sed finibus ante. Nunc finibus nulla neque, at egestas neque laoreet non. Nunc consectetur efficitur velit vel eleifend. Maecenas faucibus mattis placerat. Vestibulum ut orci sollicitudin, placerat neque eu, rhoncus tortor.

Vivamus vel lectus a ligula cursus imperdiet non ac libero. Suspendisse gravida porttitor interdum. Donec convallis rutrum ligula, in ultricies nisi blandit sed. Integer a eros eu enim viverra pellentesque. Maecenas mollis dignissim blandit. Sed ac libero ac lacus vehicula malesuada. Mauris vulputate venenatis libero quis rhoncus. Maecenas eget efficitur sem, aliquam gravida purus. Donec semper massa ac congue dapibus. Suspendisse felis tortor, aliquam eu vestibulum in, pharetra eu est.

Suspendisse non placerat libero, eu pulvinar mauris. Pellentesque aliquet augue a neque pulvinar, eget aliquet dui blandit. Cras fermentum neque non ipsum interdum, nec pharetra enim hendrerit. Maecenas finibus nulla vitae congue dictum. Aliquam at enim nec erat tempus posuere id a risus. Phasellus tempus tortor et erat luctus, a lobortis eros tempor. Vivamus non ipsum leo. Nulla viverra placerat ligula a vehicula. Fusce metus quam, dictum a dui ac, tristique malesuada lectus. Nunc blandit lorem sit amet ex commodo, nec tincidunt tellus egestas. Nulla varius elit id arcu porttitor, at bibendum neque blandit. Duis posuere lacinia nulla vel viverra.''',
          ),
        ]),
      ],
    );
  }
}
