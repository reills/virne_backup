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
  id 1591
  arrival_time 35802.086182489664
  lifetime 7.978459948727828
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 1
    gpu 0
    rom 26
  ]
  node [
    id 1
    label "1"
    cpu 3
    gpu 9
    rom 23
  ]
  node [
    id 2
    label "2"
    cpu 18
    gpu 6
    rom 18
  ]
  node [
    id 3
    label "3"
    cpu 6
    gpu 13
    rom 35
  ]
  node [
    id 4
    label "4"
    cpu 20
    gpu 13
    rom 3
  ]
  edge [
    source 0
    target 1
    bw 46
  ]
  edge [
    source 1
    target 2
    bw 30
  ]
  edge [
    source 2
    target 3
    bw 22
  ]
  edge [
    source 3
    target 4
    bw 41
  ]
]
