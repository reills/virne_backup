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
  id 1041
  arrival_time 21960.894886450646
  lifetime 430.39376936441323
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 22
    gpu 41
    rom 21
  ]
  node [
    id 1
    label "1"
    cpu 25
    gpu 37
    rom 3
  ]
  node [
    id 2
    label "2"
    cpu 18
    gpu 36
    rom 46
  ]
  node [
    id 3
    label "3"
    cpu 3
    gpu 6
    rom 15
  ]
  node [
    id 4
    label "4"
    cpu 0
    gpu 15
    rom 4
  ]
  node [
    id 5
    label "5"
    cpu 37
    gpu 8
    rom 3
  ]
  node [
    id 6
    label "6"
    cpu 3
    gpu 37
    rom 49
  ]
  node [
    id 7
    label "7"
    cpu 29
    gpu 21
    rom 8
  ]
  node [
    id 8
    label "8"
    cpu 49
    gpu 44
    rom 35
  ]
  node [
    id 9
    label "9"
    cpu 34
    gpu 23
    rom 31
  ]
  node [
    id 10
    label "10"
    cpu 27
    gpu 0
    rom 49
  ]
  node [
    id 11
    label "11"
    cpu 3
    gpu 12
    rom 44
  ]
  edge [
    source 0
    target 1
    bw 26
  ]
  edge [
    source 1
    target 2
    bw 11
  ]
  edge [
    source 2
    target 3
    bw 4
  ]
  edge [
    source 3
    target 4
    bw 24
  ]
  edge [
    source 4
    target 5
    bw 0
  ]
  edge [
    source 5
    target 6
    bw 31
  ]
  edge [
    source 6
    target 7
    bw 17
  ]
  edge [
    source 7
    target 8
    bw 16
  ]
  edge [
    source 8
    target 9
    bw 44
  ]
  edge [
    source 9
    target 10
    bw 44
  ]
  edge [
    source 10
    target 11
    bw 45
  ]
]
