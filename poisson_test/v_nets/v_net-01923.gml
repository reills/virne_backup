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
  id 1923
  arrival_time 42166.52768119094
  lifetime 6503.997703138139
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 31
    gpu 12
    rom 20
  ]
  node [
    id 1
    label "1"
    cpu 36
    gpu 32
    rom 33
  ]
  node [
    id 2
    label "2"
    cpu 30
    gpu 1
    rom 50
  ]
  node [
    id 3
    label "3"
    cpu 48
    gpu 45
    rom 24
  ]
  node [
    id 4
    label "4"
    cpu 29
    gpu 37
    rom 40
  ]
  node [
    id 5
    label "5"
    cpu 31
    gpu 10
    rom 42
  ]
  node [
    id 6
    label "6"
    cpu 36
    gpu 17
    rom 43
  ]
  node [
    id 7
    label "7"
    cpu 4
    gpu 30
    rom 50
  ]
  node [
    id 8
    label "8"
    cpu 12
    gpu 32
    rom 34
  ]
  node [
    id 9
    label "9"
    cpu 28
    gpu 39
    rom 45
  ]
  node [
    id 10
    label "10"
    cpu 19
    gpu 6
    rom 15
  ]
  node [
    id 11
    label "11"
    cpu 50
    gpu 29
    rom 29
  ]
  edge [
    source 0
    target 1
    bw 10
  ]
  edge [
    source 1
    target 2
    bw 23
  ]
  edge [
    source 2
    target 3
    bw 11
  ]
  edge [
    source 3
    target 4
    bw 14
  ]
  edge [
    source 4
    target 5
    bw 19
  ]
  edge [
    source 5
    target 6
    bw 8
  ]
  edge [
    source 6
    target 7
    bw 21
  ]
  edge [
    source 7
    target 8
    bw 19
  ]
  edge [
    source 8
    target 9
    bw 39
  ]
  edge [
    source 9
    target 10
    bw 21
  ]
  edge [
    source 10
    target 11
    bw 49
  ]
]
