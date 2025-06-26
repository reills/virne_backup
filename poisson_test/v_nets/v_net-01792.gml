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
  id 1792
  arrival_time 39841.75267084827
  lifetime 694.1069963719224
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 46
    gpu 8
    rom 24
  ]
  node [
    id 1
    label "1"
    cpu 20
    gpu 29
    rom 20
  ]
  node [
    id 2
    label "2"
    cpu 29
    gpu 4
    rom 29
  ]
  node [
    id 3
    label "3"
    cpu 31
    gpu 50
    rom 24
  ]
  node [
    id 4
    label "4"
    cpu 25
    gpu 39
    rom 32
  ]
  edge [
    source 0
    target 1
    bw 37
  ]
  edge [
    source 1
    target 2
    bw 20
  ]
  edge [
    source 2
    target 3
    bw 15
  ]
  edge [
    source 3
    target 4
    bw 45
  ]
]
