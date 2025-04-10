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
  id 902
  arrival_time 19315.20230066
  lifetime 327.65267074734714
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 46
    gpu 38
    rom 48
  ]
  node [
    id 1
    label "1"
    cpu 21
    gpu 8
    rom 11
  ]
  node [
    id 2
    label "2"
    cpu 16
    gpu 10
    rom 21
  ]
  node [
    id 3
    label "3"
    cpu 23
    gpu 8
    rom 42
  ]
  node [
    id 4
    label "4"
    cpu 26
    gpu 20
    rom 37
  ]
  node [
    id 5
    label "5"
    cpu 50
    gpu 49
    rom 2
  ]
  node [
    id 6
    label "6"
    cpu 42
    gpu 4
    rom 34
  ]
  node [
    id 7
    label "7"
    cpu 14
    gpu 1
    rom 14
  ]
  node [
    id 8
    label "8"
    cpu 29
    gpu 27
    rom 38
  ]
  node [
    id 9
    label "9"
    cpu 49
    gpu 40
    rom 28
  ]
  node [
    id 10
    label "10"
    cpu 17
    gpu 17
    rom 32
  ]
  node [
    id 11
    label "11"
    cpu 34
    gpu 38
    rom 12
  ]
  node [
    id 12
    label "12"
    cpu 2
    gpu 43
    rom 9
  ]
  node [
    id 13
    label "13"
    cpu 3
    gpu 28
    rom 15
  ]
  edge [
    source 0
    target 1
    bw 20
  ]
  edge [
    source 1
    target 2
    bw 31
  ]
  edge [
    source 2
    target 3
    bw 26
  ]
  edge [
    source 3
    target 4
    bw 40
  ]
  edge [
    source 4
    target 5
    bw 19
  ]
  edge [
    source 5
    target 6
    bw 3
  ]
  edge [
    source 6
    target 7
    bw 38
  ]
  edge [
    source 7
    target 8
    bw 30
  ]
  edge [
    source 8
    target 9
    bw 5
  ]
  edge [
    source 9
    target 10
    bw 20
  ]
  edge [
    source 10
    target 11
    bw 15
  ]
  edge [
    source 11
    target 12
    bw 47
  ]
  edge [
    source 12
    target 13
    bw 0
  ]
]
