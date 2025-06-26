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
  id 430
  arrival_time 8400.168009013429
  lifetime 175.26238190539559
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 26
    gpu 20
    rom 25
  ]
  node [
    id 1
    label "1"
    cpu 29
    gpu 32
    rom 36
  ]
  node [
    id 2
    label "2"
    cpu 46
    gpu 10
    rom 41
  ]
  node [
    id 3
    label "3"
    cpu 44
    gpu 38
    rom 24
  ]
  node [
    id 4
    label "4"
    cpu 14
    gpu 44
    rom 9
  ]
  node [
    id 5
    label "5"
    cpu 6
    gpu 5
    rom 33
  ]
  node [
    id 6
    label "6"
    cpu 30
    gpu 33
    rom 4
  ]
  node [
    id 7
    label "7"
    cpu 44
    gpu 32
    rom 37
  ]
  node [
    id 8
    label "8"
    cpu 39
    gpu 24
    rom 7
  ]
  edge [
    source 0
    target 1
    bw 25
  ]
  edge [
    source 1
    target 2
    bw 14
  ]
  edge [
    source 2
    target 3
    bw 30
  ]
  edge [
    source 3
    target 4
    bw 1
  ]
  edge [
    source 4
    target 5
    bw 34
  ]
  edge [
    source 5
    target 6
    bw 36
  ]
  edge [
    source 6
    target 7
    bw 47
  ]
  edge [
    source 7
    target 8
    bw 1
  ]
]
