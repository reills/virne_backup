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
  id 311
  arrival_time 5839.835085557539
  lifetime 345.11584226110847
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 36
    gpu 22
    rom 3
  ]
  node [
    id 1
    label "1"
    cpu 17
    gpu 38
    rom 7
  ]
  node [
    id 2
    label "2"
    cpu 46
    gpu 28
    rom 40
  ]
  node [
    id 3
    label "3"
    cpu 34
    gpu 19
    rom 29
  ]
  node [
    id 4
    label "4"
    cpu 7
    gpu 17
    rom 4
  ]
  node [
    id 5
    label "5"
    cpu 35
    gpu 47
    rom 30
  ]
  edge [
    source 0
    target 1
    bw 16
  ]
  edge [
    source 1
    target 2
    bw 5
  ]
  edge [
    source 2
    target 3
    bw 21
  ]
  edge [
    source 3
    target 4
    bw 26
  ]
  edge [
    source 4
    target 5
    bw 30
  ]
]
