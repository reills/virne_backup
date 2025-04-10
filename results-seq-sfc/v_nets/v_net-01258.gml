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
  id 1258
  arrival_time 26282.664130774487
  lifetime 486.7292957579419
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 40
    gpu 10
    rom 26
  ]
  node [
    id 1
    label "1"
    cpu 11
    gpu 36
    rom 35
  ]
  node [
    id 2
    label "2"
    cpu 10
    gpu 39
    rom 41
  ]
  node [
    id 3
    label "3"
    cpu 39
    gpu 3
    rom 39
  ]
  node [
    id 4
    label "4"
    cpu 50
    gpu 2
    rom 40
  ]
  node [
    id 5
    label "5"
    cpu 38
    gpu 11
    rom 20
  ]
  edge [
    source 0
    target 1
    bw 12
  ]
  edge [
    source 1
    target 2
    bw 24
  ]
  edge [
    source 2
    target 3
    bw 3
  ]
  edge [
    source 3
    target 4
    bw 11
  ]
  edge [
    source 4
    target 5
    bw 23
  ]
]
