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
  id 1775
  arrival_time 39471.65798616691
  lifetime 545.8875649993452
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 50
    gpu 35
    rom 41
  ]
  node [
    id 1
    label "1"
    cpu 0
    gpu 16
    rom 30
  ]
  node [
    id 2
    label "2"
    cpu 21
    gpu 33
    rom 47
  ]
  node [
    id 3
    label "3"
    cpu 39
    gpu 43
    rom 3
  ]
  node [
    id 4
    label "4"
    cpu 47
    gpu 3
    rom 1
  ]
  node [
    id 5
    label "5"
    cpu 23
    gpu 31
    rom 32
  ]
  node [
    id 6
    label "6"
    cpu 25
    gpu 23
    rom 26
  ]
  edge [
    source 0
    target 1
    bw 9
  ]
  edge [
    source 1
    target 2
    bw 29
  ]
  edge [
    source 2
    target 3
    bw 15
  ]
  edge [
    source 3
    target 4
    bw 33
  ]
  edge [
    source 4
    target 5
    bw 3
  ]
  edge [
    source 5
    target 6
    bw 34
  ]
]
