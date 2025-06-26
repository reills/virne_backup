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
  id 1080
  arrival_time 22588.975598178098
  lifetime 56.293289162336194
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 26
    gpu 13
    rom 16
  ]
  node [
    id 1
    label "1"
    cpu 48
    gpu 42
    rom 38
  ]
  node [
    id 2
    label "2"
    cpu 18
    gpu 1
    rom 42
  ]
  node [
    id 3
    label "3"
    cpu 24
    gpu 8
    rom 39
  ]
  node [
    id 4
    label "4"
    cpu 9
    gpu 14
    rom 16
  ]
  node [
    id 5
    label "5"
    cpu 4
    gpu 23
    rom 46
  ]
  node [
    id 6
    label "6"
    cpu 35
    gpu 44
    rom 1
  ]
  node [
    id 7
    label "7"
    cpu 32
    gpu 36
    rom 34
  ]
  node [
    id 8
    label "8"
    cpu 40
    gpu 45
    rom 13
  ]
  node [
    id 9
    label "9"
    cpu 8
    gpu 29
    rom 17
  ]
  node [
    id 10
    label "10"
    cpu 22
    gpu 34
    rom 3
  ]
  node [
    id 11
    label "11"
    cpu 24
    gpu 32
    rom 39
  ]
  node [
    id 12
    label "12"
    cpu 29
    gpu 0
    rom 8
  ]
  edge [
    source 0
    target 1
    bw 28
  ]
  edge [
    source 1
    target 2
    bw 8
  ]
  edge [
    source 2
    target 3
    bw 23
  ]
  edge [
    source 3
    target 4
    bw 6
  ]
  edge [
    source 4
    target 5
    bw 6
  ]
  edge [
    source 5
    target 6
    bw 15
  ]
  edge [
    source 6
    target 7
    bw 26
  ]
  edge [
    source 7
    target 8
    bw 24
  ]
  edge [
    source 8
    target 9
    bw 41
  ]
  edge [
    source 9
    target 10
    bw 8
  ]
  edge [
    source 10
    target 11
    bw 22
  ]
  edge [
    source 11
    target 12
    bw 33
  ]
]
