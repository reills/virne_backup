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
  id 1598
  arrival_time 35869.89498475599
  lifetime 748.8742316911056
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 4
    gpu 50
    rom 26
  ]
  node [
    id 1
    label "1"
    cpu 47
    gpu 8
    rom 37
  ]
  node [
    id 2
    label "2"
    cpu 43
    gpu 36
    rom 41
  ]
  node [
    id 3
    label "3"
    cpu 9
    gpu 30
    rom 45
  ]
  node [
    id 4
    label "4"
    cpu 4
    gpu 11
    rom 40
  ]
  node [
    id 5
    label "5"
    cpu 21
    gpu 17
    rom 46
  ]
  node [
    id 6
    label "6"
    cpu 35
    gpu 47
    rom 11
  ]
  node [
    id 7
    label "7"
    cpu 30
    gpu 34
    rom 49
  ]
  edge [
    source 0
    target 1
    bw 13
  ]
  edge [
    source 1
    target 2
    bw 38
  ]
  edge [
    source 2
    target 3
    bw 17
  ]
  edge [
    source 3
    target 4
    bw 8
  ]
  edge [
    source 4
    target 5
    bw 43
  ]
  edge [
    source 5
    target 6
    bw 21
  ]
  edge [
    source 6
    target 7
    bw 25
  ]
]
