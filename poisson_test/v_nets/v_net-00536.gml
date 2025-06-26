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
  id 536
  arrival_time 10214.287974803945
  lifetime 512.4537492176967
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 26
    gpu 16
    rom 19
  ]
  node [
    id 1
    label "1"
    cpu 30
    gpu 43
    rom 29
  ]
  node [
    id 2
    label "2"
    cpu 37
    gpu 45
    rom 27
  ]
  node [
    id 3
    label "3"
    cpu 30
    gpu 29
    rom 40
  ]
  node [
    id 4
    label "4"
    cpu 48
    gpu 17
    rom 16
  ]
  node [
    id 5
    label "5"
    cpu 37
    gpu 40
    rom 13
  ]
  edge [
    source 0
    target 1
    bw 36
  ]
  edge [
    source 1
    target 2
    bw 24
  ]
  edge [
    source 2
    target 3
    bw 33
  ]
  edge [
    source 3
    target 4
    bw 5
  ]
  edge [
    source 4
    target 5
    bw 16
  ]
]
