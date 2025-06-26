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
  id 1770
  arrival_time 39453.32873661958
  lifetime 695.4524084129772
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 0
    gpu 26
    rom 14
  ]
  node [
    id 1
    label "1"
    cpu 23
    gpu 12
    rom 22
  ]
  node [
    id 2
    label "2"
    cpu 40
    gpu 28
    rom 6
  ]
  node [
    id 3
    label "3"
    cpu 10
    gpu 15
    rom 27
  ]
  node [
    id 4
    label "4"
    cpu 19
    gpu 25
    rom 21
  ]
  edge [
    source 0
    target 1
    bw 34
  ]
  edge [
    source 1
    target 2
    bw 4
  ]
  edge [
    source 2
    target 3
    bw 27
  ]
  edge [
    source 3
    target 4
    bw 37
  ]
]
