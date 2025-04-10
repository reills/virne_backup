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
  id 321
  arrival_time 6120.779895396652
  lifetime 183.71406128092602
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 0
    gpu 50
    rom 17
  ]
  node [
    id 1
    label "1"
    cpu 35
    gpu 25
    rom 44
  ]
  node [
    id 2
    label "2"
    cpu 47
    gpu 48
    rom 23
  ]
  node [
    id 3
    label "3"
    cpu 23
    gpu 29
    rom 8
  ]
  node [
    id 4
    label "4"
    cpu 50
    gpu 2
    rom 2
  ]
  node [
    id 5
    label "5"
    cpu 38
    gpu 41
    rom 19
  ]
  edge [
    source 0
    target 1
    bw 19
  ]
  edge [
    source 1
    target 2
    bw 17
  ]
  edge [
    source 2
    target 3
    bw 4
  ]
  edge [
    source 3
    target 4
    bw 13
  ]
  edge [
    source 4
    target 5
    bw 3
  ]
]
