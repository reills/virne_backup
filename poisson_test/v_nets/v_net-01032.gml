graph [
  node_attrs_setting [
    name "cpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "gpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "rom"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  link_attrs_setting "_networkx_list_start"
  link_attrs_setting [
    name "bw"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "link"
    type "resource"
  ]
  id 1032
  arrival_time 21865.810596151445
  lifetime 395.06037538378905
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 33
    gpu 4
    rom 0
  ]
  node [
    id 1
    label "1"
    cpu 50
    gpu 0
    rom 23
  ]
  node [
    id 2
    label "2"
    cpu 23
    gpu 31
    rom 7
  ]
  node [
    id 3
    label "3"
    cpu 45
    gpu 23
    rom 29
  ]
  node [
    id 4
    label "4"
    cpu 28
    gpu 17
    rom 13
  ]
  node [
    id 5
    label "5"
    cpu 3
    gpu 3
    rom 20
  ]
  node [
    id 6
    label "6"
    cpu 25
    gpu 6
    rom 39
  ]
  node [
    id 7
    label "7"
    cpu 19
    gpu 40
    rom 46
  ]
  node [
    id 8
    label "8"
    cpu 50
    gpu 34
    rom 42
  ]
  node [
    id 9
    label "9"
    cpu 48
    gpu 14
    rom 46
  ]
  node [
    id 10
    label "10"
    cpu 12
    gpu 15
    rom 12
  ]
  edge [
    source 0
    target 1
    bw 15
  ]
  edge [
    source 1
    target 2
    bw 42
  ]
  edge [
    source 2
    target 3
    bw 18
  ]
  edge [
    source 3
    target 4
    bw 32
  ]
  edge [
    source 4
    target 5
    bw 5
  ]
  edge [
    source 5
    target 6
    bw 19
  ]
  edge [
    source 6
    target 7
    bw 23
  ]
  edge [
    source 7
    target 8
    bw 24
  ]
  edge [
    source 8
    target 9
    bw 32
  ]
  edge [
    source 9
    target 10
    bw 46
  ]
]
