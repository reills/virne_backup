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
  id 929
  arrival_time 19957.716522442002
  lifetime 1274.9648278782458
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 10
    gpu 19
    rom 46
  ]
  node [
    id 1
    label "1"
    cpu 22
    gpu 2
    rom 7
  ]
  node [
    id 2
    label "2"
    cpu 2
    gpu 46
    rom 24
  ]
  node [
    id 3
    label "3"
    cpu 37
    gpu 6
    rom 30
  ]
  node [
    id 4
    label "4"
    cpu 49
    gpu 25
    rom 34
  ]
  node [
    id 5
    label "5"
    cpu 20
    gpu 16
    rom 29
  ]
  node [
    id 6
    label "6"
    cpu 7
    gpu 24
    rom 39
  ]
  node [
    id 7
    label "7"
    cpu 39
    gpu 22
    rom 4
  ]
  node [
    id 8
    label "8"
    cpu 45
    gpu 47
    rom 19
  ]
  edge [
    source 0
    target 1
    bw 44
  ]
  edge [
    source 1
    target 2
    bw 41
  ]
  edge [
    source 2
    target 3
    bw 32
  ]
  edge [
    source 3
    target 4
    bw 19
  ]
  edge [
    source 4
    target 5
    bw 32
  ]
  edge [
    source 5
    target 6
    bw 20
  ]
  edge [
    source 6
    target 7
    bw 25
  ]
  edge [
    source 7
    target 8
    bw 15
  ]
]
