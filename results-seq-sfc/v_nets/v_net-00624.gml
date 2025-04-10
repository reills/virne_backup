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
  id 624
  arrival_time 12853.84354796576
  lifetime 134.7035490014545
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 34
    gpu 44
    rom 3
  ]
  node [
    id 1
    label "1"
    cpu 40
    gpu 7
    rom 7
  ]
  node [
    id 2
    label "2"
    cpu 45
    gpu 46
    rom 4
  ]
  node [
    id 3
    label "3"
    cpu 50
    gpu 27
    rom 38
  ]
  node [
    id 4
    label "4"
    cpu 22
    gpu 18
    rom 5
  ]
  node [
    id 5
    label "5"
    cpu 19
    gpu 40
    rom 3
  ]
  edge [
    source 0
    target 1
    bw 33
  ]
  edge [
    source 1
    target 2
    bw 21
  ]
  edge [
    source 2
    target 3
    bw 26
  ]
  edge [
    source 3
    target 4
    bw 10
  ]
  edge [
    source 4
    target 5
    bw 48
  ]
]
