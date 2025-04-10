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
  id 1657
  arrival_time 37028.98228662097
  lifetime 587.8356506453957
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 36
    gpu 0
    rom 19
  ]
  node [
    id 1
    label "1"
    cpu 8
    gpu 29
    rom 35
  ]
  node [
    id 2
    label "2"
    cpu 29
    gpu 43
    rom 44
  ]
  node [
    id 3
    label "3"
    cpu 45
    gpu 26
    rom 2
  ]
  node [
    id 4
    label "4"
    cpu 43
    gpu 16
    rom 5
  ]
  node [
    id 5
    label "5"
    cpu 13
    gpu 46
    rom 20
  ]
  edge [
    source 0
    target 1
    bw 11
  ]
  edge [
    source 1
    target 2
    bw 5
  ]
  edge [
    source 2
    target 3
    bw 2
  ]
  edge [
    source 3
    target 4
    bw 13
  ]
  edge [
    source 4
    target 5
    bw 8
  ]
]
