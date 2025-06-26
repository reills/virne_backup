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
  id 262
  arrival_time 5119.675805812203
  lifetime 96.41604031418869
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 10
    gpu 50
    rom 26
  ]
  node [
    id 1
    label "1"
    cpu 20
    gpu 31
    rom 44
  ]
  node [
    id 2
    label "2"
    cpu 44
    gpu 11
    rom 48
  ]
  node [
    id 3
    label "3"
    cpu 39
    gpu 38
    rom 10
  ]
  node [
    id 4
    label "4"
    cpu 1
    gpu 33
    rom 33
  ]
  node [
    id 5
    label "5"
    cpu 19
    gpu 6
    rom 24
  ]
  edge [
    source 0
    target 1
    bw 49
  ]
  edge [
    source 1
    target 2
    bw 5
  ]
  edge [
    source 2
    target 3
    bw 13
  ]
  edge [
    source 3
    target 4
    bw 25
  ]
  edge [
    source 4
    target 5
    bw 12
  ]
]
