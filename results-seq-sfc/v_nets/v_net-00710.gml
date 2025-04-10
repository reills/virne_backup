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
  id 710
  arrival_time 14852.29561747536
  lifetime 1143.567646434342
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 2
    gpu 23
    rom 33
  ]
  node [
    id 1
    label "1"
    cpu 40
    gpu 19
    rom 7
  ]
  node [
    id 2
    label "2"
    cpu 37
    gpu 11
    rom 36
  ]
  node [
    id 3
    label "3"
    cpu 15
    gpu 24
    rom 3
  ]
  node [
    id 4
    label "4"
    cpu 48
    gpu 40
    rom 49
  ]
  node [
    id 5
    label "5"
    cpu 42
    gpu 7
    rom 49
  ]
  node [
    id 6
    label "6"
    cpu 40
    gpu 29
    rom 46
  ]
  node [
    id 7
    label "7"
    cpu 19
    gpu 17
    rom 46
  ]
  node [
    id 8
    label "8"
    cpu 48
    gpu 19
    rom 44
  ]
  node [
    id 9
    label "9"
    cpu 29
    gpu 18
    rom 40
  ]
  node [
    id 10
    label "10"
    cpu 34
    gpu 6
    rom 28
  ]
  node [
    id 11
    label "11"
    cpu 25
    gpu 33
    rom 47
  ]
  node [
    id 12
    label "12"
    cpu 40
    gpu 9
    rom 27
  ]
  node [
    id 13
    label "13"
    cpu 25
    gpu 15
    rom 23
  ]
  edge [
    source 0
    target 1
    bw 18
  ]
  edge [
    source 1
    target 2
    bw 31
  ]
  edge [
    source 2
    target 3
    bw 44
  ]
  edge [
    source 3
    target 4
    bw 45
  ]
  edge [
    source 4
    target 5
    bw 46
  ]
  edge [
    source 5
    target 6
    bw 23
  ]
  edge [
    source 6
    target 7
    bw 27
  ]
  edge [
    source 7
    target 8
    bw 43
  ]
  edge [
    source 8
    target 9
    bw 35
  ]
  edge [
    source 9
    target 10
    bw 29
  ]
  edge [
    source 10
    target 11
    bw 41
  ]
  edge [
    source 11
    target 12
    bw 14
  ]
  edge [
    source 12
    target 13
    bw 36
  ]
]
