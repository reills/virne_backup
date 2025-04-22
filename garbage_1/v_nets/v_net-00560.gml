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
  id 560
  arrival_time 10536.980186153001
  lifetime 84.30274498998622
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 28
    gpu 26
    rom 32
  ]
  node [
    id 1
    label "1"
    cpu 4
    gpu 2
    rom 25
  ]
  node [
    id 2
    label "2"
    cpu 16
    gpu 45
    rom 35
  ]
  node [
    id 3
    label "3"
    cpu 40
    gpu 47
    rom 15
  ]
  edge [
    source 0
    target 1
    bw 47
  ]
  edge [
    source 1
    target 2
    bw 30
  ]
  edge [
    source 2
    target 3
    bw 23
  ]
]
