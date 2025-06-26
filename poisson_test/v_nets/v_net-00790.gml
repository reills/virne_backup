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
  id 790
  arrival_time 16547.10347048149
  lifetime 251.7669868222992
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 14
    gpu 21
    rom 8
  ]
  node [
    id 1
    label "1"
    cpu 14
    gpu 33
    rom 37
  ]
  node [
    id 2
    label "2"
    cpu 30
    gpu 34
    rom 45
  ]
  node [
    id 3
    label "3"
    cpu 38
    gpu 17
    rom 23
  ]
  node [
    id 4
    label "4"
    cpu 29
    gpu 4
    rom 15
  ]
  node [
    id 5
    label "5"
    cpu 3
    gpu 33
    rom 8
  ]
  node [
    id 6
    label "6"
    cpu 11
    gpu 31
    rom 41
  ]
  node [
    id 7
    label "7"
    cpu 37
    gpu 47
    rom 42
  ]
  node [
    id 8
    label "8"
    cpu 22
    gpu 5
    rom 13
  ]
  node [
    id 9
    label "9"
    cpu 23
    gpu 20
    rom 3
  ]
  node [
    id 10
    label "10"
    cpu 10
    gpu 0
    rom 22
  ]
  node [
    id 11
    label "11"
    cpu 12
    gpu 27
    rom 7
  ]
  edge [
    source 0
    target 1
    bw 11
  ]
  edge [
    source 1
    target 2
    bw 9
  ]
  edge [
    source 2
    target 3
    bw 45
  ]
  edge [
    source 3
    target 4
    bw 39
  ]
  edge [
    source 4
    target 5
    bw 21
  ]
  edge [
    source 5
    target 6
    bw 43
  ]
  edge [
    source 6
    target 7
    bw 11
  ]
  edge [
    source 7
    target 8
    bw 3
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
    bw 28
  ]
]
