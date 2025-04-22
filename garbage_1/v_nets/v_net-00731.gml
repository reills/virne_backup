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
  id 731
  arrival_time 15348.977021148427
  lifetime 83.8435695087896
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 8
    gpu 19
    rom 11
  ]
  node [
    id 1
    label "1"
    cpu 30
    gpu 39
    rom 18
  ]
  node [
    id 2
    label "2"
    cpu 46
    gpu 14
    rom 49
  ]
  node [
    id 3
    label "3"
    cpu 4
    gpu 35
    rom 15
  ]
  node [
    id 4
    label "4"
    cpu 21
    gpu 43
    rom 45
  ]
  node [
    id 5
    label "5"
    cpu 13
    gpu 12
    rom 40
  ]
  node [
    id 6
    label "6"
    cpu 42
    gpu 20
    rom 39
  ]
  node [
    id 7
    label "7"
    cpu 39
    gpu 30
    rom 0
  ]
  node [
    id 8
    label "8"
    cpu 23
    gpu 32
    rom 41
  ]
  node [
    id 9
    label "9"
    cpu 28
    gpu 32
    rom 5
  ]
  node [
    id 10
    label "10"
    cpu 46
    gpu 19
    rom 16
  ]
  node [
    id 11
    label "11"
    cpu 7
    gpu 46
    rom 35
  ]
  node [
    id 12
    label "12"
    cpu 0
    gpu 3
    rom 39
  ]
  node [
    id 13
    label "13"
    cpu 33
    gpu 48
    rom 0
  ]
  node [
    id 14
    label "14"
    cpu 17
    gpu 23
    rom 40
  ]
  edge [
    source 0
    target 1
    bw 49
  ]
  edge [
    source 1
    target 2
    bw 23
  ]
  edge [
    source 2
    target 3
    bw 9
  ]
  edge [
    source 3
    target 4
    bw 36
  ]
  edge [
    source 4
    target 5
    bw 50
  ]
  edge [
    source 5
    target 6
    bw 21
  ]
  edge [
    source 6
    target 7
    bw 38
  ]
  edge [
    source 7
    target 8
    bw 23
  ]
  edge [
    source 8
    target 9
    bw 50
  ]
  edge [
    source 9
    target 10
    bw 7
  ]
  edge [
    source 10
    target 11
    bw 3
  ]
  edge [
    source 11
    target 12
    bw 29
  ]
  edge [
    source 12
    target 13
    bw 37
  ]
  edge [
    source 13
    target 14
    bw 47
  ]
]
