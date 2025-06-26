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
  id 641
  arrival_time 13371.535273073876
  lifetime 4396.253511566406
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 13
    gpu 3
    rom 40
  ]
  node [
    id 1
    label "1"
    cpu 3
    gpu 5
    rom 35
  ]
  node [
    id 2
    label "2"
    cpu 26
    gpu 18
    rom 50
  ]
  node [
    id 3
    label "3"
    cpu 42
    gpu 16
    rom 21
  ]
  node [
    id 4
    label "4"
    cpu 44
    gpu 22
    rom 30
  ]
  node [
    id 5
    label "5"
    cpu 33
    gpu 26
    rom 15
  ]
  edge [
    source 0
    target 1
    bw 27
  ]
  edge [
    source 1
    target 2
    bw 42
  ]
  edge [
    source 2
    target 3
    bw 37
  ]
  edge [
    source 3
    target 4
    bw 46
  ]
  edge [
    source 4
    target 5
    bw 15
  ]
]
