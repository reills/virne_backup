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
  id 1189
  arrival_time 24690.122468522266
  lifetime 173.23279282454186
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 28
    gpu 25
    rom 10
  ]
  node [
    id 1
    label "1"
    cpu 21
    gpu 3
    rom 18
  ]
  node [
    id 2
    label "2"
    cpu 38
    gpu 0
    rom 14
  ]
  node [
    id 3
    label "3"
    cpu 42
    gpu 29
    rom 12
  ]
  node [
    id 4
    label "4"
    cpu 48
    gpu 16
    rom 39
  ]
  node [
    id 5
    label "5"
    cpu 20
    gpu 17
    rom 8
  ]
  node [
    id 6
    label "6"
    cpu 27
    gpu 48
    rom 30
  ]
  node [
    id 7
    label "7"
    cpu 8
    gpu 19
    rom 13
  ]
  node [
    id 8
    label "8"
    cpu 50
    gpu 12
    rom 9
  ]
  node [
    id 9
    label "9"
    cpu 5
    gpu 11
    rom 23
  ]
  node [
    id 10
    label "10"
    cpu 10
    gpu 27
    rom 8
  ]
  node [
    id 11
    label "11"
    cpu 6
    gpu 21
    rom 48
  ]
  node [
    id 12
    label "12"
    cpu 42
    gpu 23
    rom 29
  ]
  node [
    id 13
    label "13"
    cpu 33
    gpu 18
    rom 1
  ]
  node [
    id 14
    label "14"
    cpu 24
    gpu 37
    rom 39
  ]
  edge [
    source 0
    target 1
    bw 0
  ]
  edge [
    source 1
    target 2
    bw 35
  ]
  edge [
    source 2
    target 3
    bw 7
  ]
  edge [
    source 3
    target 4
    bw 43
  ]
  edge [
    source 4
    target 5
    bw 45
  ]
  edge [
    source 5
    target 6
    bw 9
  ]
  edge [
    source 6
    target 7
    bw 8
  ]
  edge [
    source 7
    target 8
    bw 44
  ]
  edge [
    source 8
    target 9
    bw 11
  ]
  edge [
    source 9
    target 10
    bw 46
  ]
  edge [
    source 10
    target 11
    bw 41
  ]
  edge [
    source 11
    target 12
    bw 7
  ]
  edge [
    source 12
    target 13
    bw 15
  ]
  edge [
    source 13
    target 14
    bw 21
  ]
]
