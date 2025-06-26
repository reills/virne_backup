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
  id 988
  arrival_time 21029.443394664973
  lifetime 409.3948998002109
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 12
    gpu 49
    rom 47
  ]
  node [
    id 1
    label "1"
    cpu 44
    gpu 14
    rom 16
  ]
  node [
    id 2
    label "2"
    cpu 47
    gpu 48
    rom 36
  ]
  node [
    id 3
    label "3"
    cpu 32
    gpu 5
    rom 49
  ]
  node [
    id 4
    label "4"
    cpu 10
    gpu 50
    rom 26
  ]
  node [
    id 5
    label "5"
    cpu 7
    gpu 49
    rom 19
  ]
  node [
    id 6
    label "6"
    cpu 20
    gpu 30
    rom 3
  ]
  node [
    id 7
    label "7"
    cpu 49
    gpu 36
    rom 23
  ]
  node [
    id 8
    label "8"
    cpu 0
    gpu 21
    rom 14
  ]
  node [
    id 9
    label "9"
    cpu 33
    gpu 17
    rom 38
  ]
  node [
    id 10
    label "10"
    cpu 13
    gpu 41
    rom 47
  ]
  node [
    id 11
    label "11"
    cpu 6
    gpu 22
    rom 15
  ]
  edge [
    source 0
    target 1
    bw 5
  ]
  edge [
    source 1
    target 2
    bw 3
  ]
  edge [
    source 2
    target 3
    bw 50
  ]
  edge [
    source 3
    target 4
    bw 4
  ]
  edge [
    source 4
    target 5
    bw 18
  ]
  edge [
    source 5
    target 6
    bw 12
  ]
  edge [
    source 6
    target 7
    bw 39
  ]
  edge [
    source 7
    target 8
    bw 36
  ]
  edge [
    source 8
    target 9
    bw 16
  ]
  edge [
    source 9
    target 10
    bw 17
  ]
  edge [
    source 10
    target 11
    bw 25
  ]
]
