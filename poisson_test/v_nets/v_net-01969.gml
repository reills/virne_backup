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
  id 1969
  arrival_time 42980.95658438682
  lifetime 513.4513986217603
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 20
    gpu 34
    rom 32
  ]
  node [
    id 1
    label "1"
    cpu 37
    gpu 48
    rom 48
  ]
  node [
    id 2
    label "2"
    cpu 0
    gpu 22
    rom 19
  ]
  node [
    id 3
    label "3"
    cpu 11
    gpu 48
    rom 40
  ]
  node [
    id 4
    label "4"
    cpu 2
    gpu 0
    rom 42
  ]
  node [
    id 5
    label "5"
    cpu 12
    gpu 23
    rom 16
  ]
  node [
    id 6
    label "6"
    cpu 34
    gpu 27
    rom 40
  ]
  node [
    id 7
    label "7"
    cpu 2
    gpu 37
    rom 7
  ]
  node [
    id 8
    label "8"
    cpu 6
    gpu 49
    rom 34
  ]
  node [
    id 9
    label "9"
    cpu 37
    gpu 32
    rom 15
  ]
  node [
    id 10
    label "10"
    cpu 15
    gpu 3
    rom 44
  ]
  node [
    id 11
    label "11"
    cpu 34
    gpu 28
    rom 7
  ]
  edge [
    source 0
    target 1
    bw 19
  ]
  edge [
    source 1
    target 2
    bw 21
  ]
  edge [
    source 2
    target 3
    bw 26
  ]
  edge [
    source 3
    target 4
    bw 38
  ]
  edge [
    source 4
    target 5
    bw 28
  ]
  edge [
    source 5
    target 6
    bw 24
  ]
  edge [
    source 6
    target 7
    bw 37
  ]
  edge [
    source 7
    target 8
    bw 28
  ]
  edge [
    source 8
    target 9
    bw 48
  ]
  edge [
    source 9
    target 10
    bw 32
  ]
  edge [
    source 10
    target 11
    bw 7
  ]
]
