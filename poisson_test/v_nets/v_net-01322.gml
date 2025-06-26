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
  id 1322
  arrival_time 27637.904456776956
  lifetime 835.9560054262611
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 3
    gpu 42
    rom 25
  ]
  node [
    id 1
    label "1"
    cpu 7
    gpu 32
    rom 24
  ]
  node [
    id 2
    label "2"
    cpu 49
    gpu 31
    rom 28
  ]
  node [
    id 3
    label "3"
    cpu 45
    gpu 13
    rom 22
  ]
  node [
    id 4
    label "4"
    cpu 6
    gpu 49
    rom 1
  ]
  node [
    id 5
    label "5"
    cpu 26
    gpu 4
    rom 50
  ]
  node [
    id 6
    label "6"
    cpu 37
    gpu 6
    rom 13
  ]
  node [
    id 7
    label "7"
    cpu 39
    gpu 20
    rom 5
  ]
  node [
    id 8
    label "8"
    cpu 5
    gpu 7
    rom 36
  ]
  node [
    id 9
    label "9"
    cpu 8
    gpu 49
    rom 49
  ]
  node [
    id 10
    label "10"
    cpu 12
    gpu 14
    rom 28
  ]
  edge [
    source 0
    target 1
    bw 11
  ]
  edge [
    source 1
    target 2
    bw 0
  ]
  edge [
    source 2
    target 3
    bw 36
  ]
  edge [
    source 3
    target 4
    bw 0
  ]
  edge [
    source 4
    target 5
    bw 26
  ]
  edge [
    source 5
    target 6
    bw 1
  ]
  edge [
    source 6
    target 7
    bw 35
  ]
  edge [
    source 7
    target 8
    bw 46
  ]
  edge [
    source 8
    target 9
    bw 8
  ]
  edge [
    source 9
    target 10
    bw 40
  ]
]
