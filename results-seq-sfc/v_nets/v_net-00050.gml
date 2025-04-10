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
  id 50
  arrival_time 1033.4076031107807
  lifetime 451.56817995044037
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 1
    gpu 32
    rom 18
  ]
  node [
    id 1
    label "1"
    cpu 29
    gpu 25
    rom 41
  ]
  node [
    id 2
    label "2"
    cpu 27
    gpu 5
    rom 29
  ]
  node [
    id 3
    label "3"
    cpu 39
    gpu 22
    rom 43
  ]
  node [
    id 4
    label "4"
    cpu 31
    gpu 38
    rom 25
  ]
  node [
    id 5
    label "5"
    cpu 33
    gpu 7
    rom 30
  ]
  node [
    id 6
    label "6"
    cpu 48
    gpu 23
    rom 27
  ]
  node [
    id 7
    label "7"
    cpu 30
    gpu 49
    rom 10
  ]
  node [
    id 8
    label "8"
    cpu 2
    gpu 49
    rom 34
  ]
  node [
    id 9
    label "9"
    cpu 29
    gpu 48
    rom 15
  ]
  node [
    id 10
    label "10"
    cpu 38
    gpu 35
    rom 9
  ]
  node [
    id 11
    label "11"
    cpu 3
    gpu 44
    rom 2
  ]
  edge [
    source 0
    target 1
    bw 36
  ]
  edge [
    source 1
    target 2
    bw 44
  ]
  edge [
    source 2
    target 3
    bw 14
  ]
  edge [
    source 3
    target 4
    bw 15
  ]
  edge [
    source 4
    target 5
    bw 37
  ]
  edge [
    source 5
    target 6
    bw 25
  ]
  edge [
    source 6
    target 7
    bw 47
  ]
  edge [
    source 7
    target 8
    bw 6
  ]
  edge [
    source 8
    target 9
    bw 38
  ]
  edge [
    source 9
    target 10
    bw 22
  ]
  edge [
    source 10
    target 11
    bw 23
  ]
]
