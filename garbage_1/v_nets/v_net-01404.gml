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
  id 1404
  arrival_time 29442.319713390825
  lifetime 589.2734040137358
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 20
    gpu 34
    rom 20
  ]
  node [
    id 1
    label "1"
    cpu 13
    gpu 22
    rom 32
  ]
  node [
    id 2
    label "2"
    cpu 18
    gpu 44
    rom 3
  ]
  node [
    id 3
    label "3"
    cpu 6
    gpu 45
    rom 47
  ]
  node [
    id 4
    label "4"
    cpu 39
    gpu 37
    rom 25
  ]
  edge [
    source 0
    target 1
    bw 5
  ]
  edge [
    source 1
    target 2
    bw 4
  ]
  edge [
    source 2
    target 3
    bw 6
  ]
  edge [
    source 3
    target 4
    bw 46
  ]
]
