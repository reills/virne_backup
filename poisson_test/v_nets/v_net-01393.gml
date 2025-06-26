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
  id 1393
  arrival_time 29342.889524508842
  lifetime 2283.6931438701276
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 25
    gpu 29
    rom 0
  ]
  node [
    id 1
    label "1"
    cpu 31
    gpu 11
    rom 39
  ]
  node [
    id 2
    label "2"
    cpu 30
    gpu 24
    rom 40
  ]
  node [
    id 3
    label "3"
    cpu 39
    gpu 26
    rom 15
  ]
  node [
    id 4
    label "4"
    cpu 6
    gpu 9
    rom 44
  ]
  node [
    id 5
    label "5"
    cpu 37
    gpu 32
    rom 1
  ]
  node [
    id 6
    label "6"
    cpu 0
    gpu 38
    rom 0
  ]
  node [
    id 7
    label "7"
    cpu 6
    gpu 26
    rom 2
  ]
  node [
    id 8
    label "8"
    cpu 21
    gpu 49
    rom 41
  ]
  node [
    id 9
    label "9"
    cpu 14
    gpu 38
    rom 44
  ]
  node [
    id 10
    label "10"
    cpu 17
    gpu 14
    rom 13
  ]
  node [
    id 11
    label "11"
    cpu 0
    gpu 47
    rom 34
  ]
  node [
    id 12
    label "12"
    cpu 37
    gpu 16
    rom 19
  ]
  node [
    id 13
    label "13"
    cpu 50
    gpu 24
    rom 34
  ]
  edge [
    source 0
    target 1
    bw 14
  ]
  edge [
    source 1
    target 2
    bw 13
  ]
  edge [
    source 2
    target 3
    bw 9
  ]
  edge [
    source 3
    target 4
    bw 4
  ]
  edge [
    source 4
    target 5
    bw 20
  ]
  edge [
    source 5
    target 6
    bw 24
  ]
  edge [
    source 6
    target 7
    bw 15
  ]
  edge [
    source 7
    target 8
    bw 13
  ]
  edge [
    source 8
    target 9
    bw 27
  ]
  edge [
    source 9
    target 10
    bw 39
  ]
  edge [
    source 10
    target 11
    bw 1
  ]
  edge [
    source 11
    target 12
    bw 30
  ]
  edge [
    source 12
    target 13
    bw 29
  ]
]
