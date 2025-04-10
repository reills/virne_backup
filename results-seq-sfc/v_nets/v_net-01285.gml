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
  id 1285
  arrival_time 26775.00108061808
  lifetime 192.12617172203673
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 22
    gpu 30
    rom 14
  ]
  node [
    id 1
    label "1"
    cpu 14
    gpu 24
    rom 43
  ]
  node [
    id 2
    label "2"
    cpu 45
    gpu 17
    rom 4
  ]
  node [
    id 3
    label "3"
    cpu 11
    gpu 33
    rom 21
  ]
  node [
    id 4
    label "4"
    cpu 38
    gpu 34
    rom 6
  ]
  node [
    id 5
    label "5"
    cpu 23
    gpu 37
    rom 14
  ]
  node [
    id 6
    label "6"
    cpu 7
    gpu 28
    rom 4
  ]
  node [
    id 7
    label "7"
    cpu 14
    gpu 26
    rom 7
  ]
  node [
    id 8
    label "8"
    cpu 19
    gpu 40
    rom 43
  ]
  node [
    id 9
    label "9"
    cpu 41
    gpu 25
    rom 13
  ]
  node [
    id 10
    label "10"
    cpu 28
    gpu 14
    rom 23
  ]
  node [
    id 11
    label "11"
    cpu 42
    gpu 45
    rom 28
  ]
  node [
    id 12
    label "12"
    cpu 28
    gpu 34
    rom 16
  ]
  node [
    id 13
    label "13"
    cpu 39
    gpu 15
    rom 21
  ]
  node [
    id 14
    label "14"
    cpu 30
    gpu 42
    rom 43
  ]
  edge [
    source 0
    target 1
    bw 27
  ]
  edge [
    source 1
    target 2
    bw 34
  ]
  edge [
    source 2
    target 3
    bw 0
  ]
  edge [
    source 3
    target 4
    bw 17
  ]
  edge [
    source 4
    target 5
    bw 42
  ]
  edge [
    source 5
    target 6
    bw 14
  ]
  edge [
    source 6
    target 7
    bw 45
  ]
  edge [
    source 7
    target 8
    bw 32
  ]
  edge [
    source 8
    target 9
    bw 29
  ]
  edge [
    source 9
    target 10
    bw 25
  ]
  edge [
    source 10
    target 11
    bw 3
  ]
  edge [
    source 11
    target 12
    bw 41
  ]
  edge [
    source 12
    target 13
    bw 7
  ]
  edge [
    source 13
    target 14
    bw 42
  ]
]
