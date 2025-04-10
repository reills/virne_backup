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
  id 1109
  arrival_time 23154.342390736972
  lifetime 571.398781670791
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 15
    gpu 49
    rom 4
  ]
  node [
    id 1
    label "1"
    cpu 5
    gpu 31
    rom 45
  ]
  node [
    id 2
    label "2"
    cpu 50
    gpu 28
    rom 11
  ]
  node [
    id 3
    label "3"
    cpu 7
    gpu 6
    rom 24
  ]
  node [
    id 4
    label "4"
    cpu 29
    gpu 14
    rom 13
  ]
  node [
    id 5
    label "5"
    cpu 2
    gpu 35
    rom 3
  ]
  node [
    id 6
    label "6"
    cpu 46
    gpu 31
    rom 42
  ]
  node [
    id 7
    label "7"
    cpu 48
    gpu 47
    rom 47
  ]
  node [
    id 8
    label "8"
    cpu 1
    gpu 36
    rom 15
  ]
  node [
    id 9
    label "9"
    cpu 26
    gpu 38
    rom 13
  ]
  node [
    id 10
    label "10"
    cpu 9
    gpu 3
    rom 19
  ]
  node [
    id 11
    label "11"
    cpu 8
    gpu 7
    rom 15
  ]
  node [
    id 12
    label "12"
    cpu 2
    gpu 11
    rom 33
  ]
  edge [
    source 0
    target 1
    bw 39
  ]
  edge [
    source 1
    target 2
    bw 50
  ]
  edge [
    source 2
    target 3
    bw 36
  ]
  edge [
    source 3
    target 4
    bw 6
  ]
  edge [
    source 4
    target 5
    bw 41
  ]
  edge [
    source 5
    target 6
    bw 39
  ]
  edge [
    source 6
    target 7
    bw 22
  ]
  edge [
    source 7
    target 8
    bw 12
  ]
  edge [
    source 8
    target 9
    bw 44
  ]
  edge [
    source 9
    target 10
    bw 16
  ]
  edge [
    source 10
    target 11
    bw 2
  ]
  edge [
    source 11
    target 12
    bw 5
  ]
]
