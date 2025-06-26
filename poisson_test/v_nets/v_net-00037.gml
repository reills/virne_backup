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
  id 37
  arrival_time 625.1252449535405
  lifetime 208.8907250141281
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 34
    gpu 34
    rom 39
  ]
  node [
    id 1
    label "1"
    cpu 33
    gpu 23
    rom 25
  ]
  node [
    id 2
    label "2"
    cpu 17
    gpu 42
    rom 40
  ]
  node [
    id 3
    label "3"
    cpu 10
    gpu 1
    rom 23
  ]
  node [
    id 4
    label "4"
    cpu 30
    gpu 15
    rom 22
  ]
  node [
    id 5
    label "5"
    cpu 29
    gpu 1
    rom 47
  ]
  node [
    id 6
    label "6"
    cpu 42
    gpu 4
    rom 36
  ]
  node [
    id 7
    label "7"
    cpu 44
    gpu 8
    rom 21
  ]
  node [
    id 8
    label "8"
    cpu 14
    gpu 23
    rom 30
  ]
  node [
    id 9
    label "9"
    cpu 45
    gpu 33
    rom 41
  ]
  node [
    id 10
    label "10"
    cpu 14
    gpu 12
    rom 26
  ]
  node [
    id 11
    label "11"
    cpu 6
    gpu 8
    rom 39
  ]
  edge [
    source 0
    target 1
    bw 18
  ]
  edge [
    source 1
    target 2
    bw 4
  ]
  edge [
    source 2
    target 3
    bw 42
  ]
  edge [
    source 3
    target 4
    bw 8
  ]
  edge [
    source 4
    target 5
    bw 20
  ]
  edge [
    source 5
    target 6
    bw 21
  ]
  edge [
    source 6
    target 7
    bw 44
  ]
  edge [
    source 7
    target 8
    bw 7
  ]
  edge [
    source 8
    target 9
    bw 2
  ]
  edge [
    source 9
    target 10
    bw 21
  ]
  edge [
    source 10
    target 11
    bw 5
  ]
]
