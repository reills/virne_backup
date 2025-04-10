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
  id 653
  arrival_time 13831.654550731817
  lifetime 1157.1599400791351
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 34
    gpu 32
    rom 34
  ]
  node [
    id 1
    label "1"
    cpu 20
    gpu 33
    rom 12
  ]
  node [
    id 2
    label "2"
    cpu 19
    gpu 17
    rom 14
  ]
  node [
    id 3
    label "3"
    cpu 18
    gpu 9
    rom 7
  ]
  node [
    id 4
    label "4"
    cpu 47
    gpu 29
    rom 44
  ]
  node [
    id 5
    label "5"
    cpu 9
    gpu 4
    rom 22
  ]
  node [
    id 6
    label "6"
    cpu 45
    gpu 26
    rom 22
  ]
  node [
    id 7
    label "7"
    cpu 25
    gpu 47
    rom 12
  ]
  edge [
    source 0
    target 1
    bw 47
  ]
  edge [
    source 1
    target 2
    bw 12
  ]
  edge [
    source 2
    target 3
    bw 43
  ]
  edge [
    source 3
    target 4
    bw 45
  ]
  edge [
    source 4
    target 5
    bw 11
  ]
  edge [
    source 5
    target 6
    bw 37
  ]
  edge [
    source 6
    target 7
    bw 21
  ]
]
