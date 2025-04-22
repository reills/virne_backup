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
  id 367
  arrival_time 6968.433289303251
  lifetime 256.5002310237247
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 10
    gpu 7
    rom 35
  ]
  node [
    id 1
    label "1"
    cpu 6
    gpu 14
    rom 46
  ]
  node [
    id 2
    label "2"
    cpu 36
    gpu 24
    rom 18
  ]
  node [
    id 3
    label "3"
    cpu 26
    gpu 39
    rom 45
  ]
  node [
    id 4
    label "4"
    cpu 50
    gpu 45
    rom 4
  ]
  node [
    id 5
    label "5"
    cpu 40
    gpu 4
    rom 44
  ]
  node [
    id 6
    label "6"
    cpu 9
    gpu 7
    rom 50
  ]
  edge [
    source 0
    target 1
    bw 20
  ]
  edge [
    source 1
    target 2
    bw 41
  ]
  edge [
    source 2
    target 3
    bw 31
  ]
  edge [
    source 3
    target 4
    bw 0
  ]
  edge [
    source 4
    target 5
    bw 18
  ]
  edge [
    source 5
    target 6
    bw 19
  ]
]
