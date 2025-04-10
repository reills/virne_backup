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
  id 473
  arrival_time 8847.304074663725
  lifetime 912.0069440786336
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 23
    gpu 39
    rom 14
  ]
  node [
    id 1
    label "1"
    cpu 43
    gpu 7
    rom 21
  ]
  node [
    id 2
    label "2"
    cpu 28
    gpu 1
    rom 19
  ]
  node [
    id 3
    label "3"
    cpu 0
    gpu 25
    rom 8
  ]
  node [
    id 4
    label "4"
    cpu 33
    gpu 14
    rom 22
  ]
  node [
    id 5
    label "5"
    cpu 10
    gpu 32
    rom 37
  ]
  node [
    id 6
    label "6"
    cpu 25
    gpu 33
    rom 24
  ]
  node [
    id 7
    label "7"
    cpu 12
    gpu 1
    rom 48
  ]
  node [
    id 8
    label "8"
    cpu 5
    gpu 10
    rom 41
  ]
  node [
    id 9
    label "9"
    cpu 28
    gpu 36
    rom 19
  ]
  node [
    id 10
    label "10"
    cpu 49
    gpu 11
    rom 16
  ]
  node [
    id 11
    label "11"
    cpu 10
    gpu 12
    rom 21
  ]
  node [
    id 12
    label "12"
    cpu 43
    gpu 15
    rom 24
  ]
  edge [
    source 0
    target 1
    bw 43
  ]
  edge [
    source 1
    target 2
    bw 30
  ]
  edge [
    source 2
    target 3
    bw 42
  ]
  edge [
    source 3
    target 4
    bw 43
  ]
  edge [
    source 4
    target 5
    bw 38
  ]
  edge [
    source 5
    target 6
    bw 22
  ]
  edge [
    source 6
    target 7
    bw 15
  ]
  edge [
    source 7
    target 8
    bw 0
  ]
  edge [
    source 8
    target 9
    bw 36
  ]
  edge [
    source 9
    target 10
    bw 7
  ]
  edge [
    source 10
    target 11
    bw 46
  ]
  edge [
    source 11
    target 12
    bw 2
  ]
]
