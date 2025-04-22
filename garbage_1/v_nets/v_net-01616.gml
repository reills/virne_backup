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
  id 1616
  arrival_time 36135.2993438479
  lifetime 445.6531961363258
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 11
    gpu 25
    rom 49
  ]
  node [
    id 1
    label "1"
    cpu 13
    gpu 2
    rom 4
  ]
  node [
    id 2
    label "2"
    cpu 46
    gpu 27
    rom 26
  ]
  node [
    id 3
    label "3"
    cpu 35
    gpu 30
    rom 15
  ]
  node [
    id 4
    label "4"
    cpu 11
    gpu 45
    rom 7
  ]
  node [
    id 5
    label "5"
    cpu 34
    gpu 13
    rom 46
  ]
  node [
    id 6
    label "6"
    cpu 26
    gpu 44
    rom 37
  ]
  edge [
    source 0
    target 1
    bw 42
  ]
  edge [
    source 1
    target 2
    bw 6
  ]
  edge [
    source 2
    target 3
    bw 34
  ]
  edge [
    source 3
    target 4
    bw 41
  ]
  edge [
    source 4
    target 5
    bw 45
  ]
  edge [
    source 5
    target 6
    bw 38
  ]
]
