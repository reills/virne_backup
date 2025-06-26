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
  id 401
  arrival_time 7877.636661663078
  lifetime 683.1480199526626
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 31
    gpu 34
    rom 48
  ]
  node [
    id 1
    label "1"
    cpu 38
    gpu 1
    rom 5
  ]
  node [
    id 2
    label "2"
    cpu 42
    gpu 29
    rom 7
  ]
  node [
    id 3
    label "3"
    cpu 28
    gpu 14
    rom 8
  ]
  node [
    id 4
    label "4"
    cpu 5
    gpu 35
    rom 25
  ]
  node [
    id 5
    label "5"
    cpu 36
    gpu 42
    rom 1
  ]
  node [
    id 6
    label "6"
    cpu 36
    gpu 5
    rom 24
  ]
  node [
    id 7
    label "7"
    cpu 36
    gpu 25
    rom 17
  ]
  node [
    id 8
    label "8"
    cpu 24
    gpu 3
    rom 33
  ]
  edge [
    source 0
    target 1
    bw 19
  ]
  edge [
    source 1
    target 2
    bw 9
  ]
  edge [
    source 2
    target 3
    bw 16
  ]
  edge [
    source 3
    target 4
    bw 21
  ]
  edge [
    source 4
    target 5
    bw 28
  ]
  edge [
    source 5
    target 6
    bw 16
  ]
  edge [
    source 6
    target 7
    bw 2
  ]
  edge [
    source 7
    target 8
    bw 27
  ]
]
