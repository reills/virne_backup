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
  id 157
  arrival_time 3024.165542170219
  lifetime 788.2054989403453
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 36
    gpu 23
    rom 32
  ]
  node [
    id 1
    label "1"
    cpu 1
    gpu 12
    rom 4
  ]
  node [
    id 2
    label "2"
    cpu 46
    gpu 21
    rom 21
  ]
  node [
    id 3
    label "3"
    cpu 34
    gpu 21
    rom 29
  ]
  node [
    id 4
    label "4"
    cpu 27
    gpu 25
    rom 0
  ]
  node [
    id 5
    label "5"
    cpu 21
    gpu 18
    rom 46
  ]
  node [
    id 6
    label "6"
    cpu 41
    gpu 24
    rom 15
  ]
  node [
    id 7
    label "7"
    cpu 26
    gpu 37
    rom 32
  ]
  node [
    id 8
    label "8"
    cpu 36
    gpu 50
    rom 23
  ]
  node [
    id 9
    label "9"
    cpu 6
    gpu 29
    rom 23
  ]
  node [
    id 10
    label "10"
    cpu 10
    gpu 42
    rom 3
  ]
  node [
    id 11
    label "11"
    cpu 30
    gpu 20
    rom 25
  ]
  node [
    id 12
    label "12"
    cpu 20
    gpu 23
    rom 19
  ]
  node [
    id 13
    label "13"
    cpu 35
    gpu 25
    rom 5
  ]
  node [
    id 14
    label "14"
    cpu 20
    gpu 19
    rom 33
  ]
  edge [
    source 0
    target 1
    bw 5
  ]
  edge [
    source 1
    target 2
    bw 24
  ]
  edge [
    source 2
    target 3
    bw 21
  ]
  edge [
    source 3
    target 4
    bw 34
  ]
  edge [
    source 4
    target 5
    bw 40
  ]
  edge [
    source 5
    target 6
    bw 44
  ]
  edge [
    source 6
    target 7
    bw 12
  ]
  edge [
    source 7
    target 8
    bw 48
  ]
  edge [
    source 8
    target 9
    bw 44
  ]
  edge [
    source 9
    target 10
    bw 33
  ]
  edge [
    source 10
    target 11
    bw 32
  ]
  edge [
    source 11
    target 12
    bw 28
  ]
  edge [
    source 12
    target 13
    bw 36
  ]
  edge [
    source 13
    target 14
    bw 26
  ]
]
