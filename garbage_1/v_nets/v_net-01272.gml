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
  id 1272
  arrival_time 26703.296559212606
  lifetime 985.6654990123947
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 25
    gpu 50
    rom 42
  ]
  node [
    id 1
    label "1"
    cpu 7
    gpu 20
    rom 38
  ]
  node [
    id 2
    label "2"
    cpu 34
    gpu 45
    rom 32
  ]
  node [
    id 3
    label "3"
    cpu 7
    gpu 12
    rom 43
  ]
  node [
    id 4
    label "4"
    cpu 5
    gpu 6
    rom 2
  ]
  node [
    id 5
    label "5"
    cpu 7
    gpu 35
    rom 38
  ]
  edge [
    source 0
    target 1
    bw 17
  ]
  edge [
    source 1
    target 2
    bw 28
  ]
  edge [
    source 2
    target 3
    bw 1
  ]
  edge [
    source 3
    target 4
    bw 38
  ]
  edge [
    source 4
    target 5
    bw 33
  ]
]
