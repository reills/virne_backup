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
  id 1476
  arrival_time 32094.517614236098
  lifetime 443.59327652134857
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 21
    gpu 30
    rom 49
  ]
  node [
    id 1
    label "1"
    cpu 19
    gpu 26
    rom 19
  ]
  node [
    id 2
    label "2"
    cpu 4
    gpu 23
    rom 9
  ]
  node [
    id 3
    label "3"
    cpu 47
    gpu 27
    rom 46
  ]
  node [
    id 4
    label "4"
    cpu 34
    gpu 38
    rom 48
  ]
  node [
    id 5
    label "5"
    cpu 45
    gpu 49
    rom 17
  ]
  node [
    id 6
    label "6"
    cpu 23
    gpu 23
    rom 28
  ]
  node [
    id 7
    label "7"
    cpu 20
    gpu 34
    rom 48
  ]
  node [
    id 8
    label "8"
    cpu 16
    gpu 36
    rom 17
  ]
  node [
    id 9
    label "9"
    cpu 19
    gpu 50
    rom 50
  ]
  node [
    id 10
    label "10"
    cpu 1
    gpu 32
    rom 35
  ]
  node [
    id 11
    label "11"
    cpu 26
    gpu 42
    rom 20
  ]
  node [
    id 12
    label "12"
    cpu 25
    gpu 9
    rom 11
  ]
  node [
    id 13
    label "13"
    cpu 28
    gpu 31
    rom 6
  ]
  node [
    id 14
    label "14"
    cpu 45
    gpu 22
    rom 21
  ]
  edge [
    source 0
    target 1
    bw 13
  ]
  edge [
    source 1
    target 2
    bw 6
  ]
  edge [
    source 2
    target 3
    bw 4
  ]
  edge [
    source 3
    target 4
    bw 50
  ]
  edge [
    source 4
    target 5
    bw 19
  ]
  edge [
    source 5
    target 6
    bw 18
  ]
  edge [
    source 6
    target 7
    bw 49
  ]
  edge [
    source 7
    target 8
    bw 34
  ]
  edge [
    source 8
    target 9
    bw 47
  ]
  edge [
    source 9
    target 10
    bw 49
  ]
  edge [
    source 10
    target 11
    bw 31
  ]
  edge [
    source 11
    target 12
    bw 2
  ]
  edge [
    source 12
    target 13
    bw 25
  ]
  edge [
    source 13
    target 14
    bw 33
  ]
]
