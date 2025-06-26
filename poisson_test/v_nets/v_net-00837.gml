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
  id 837
  arrival_time 17357.847395234134
  lifetime 1477.9453506312761
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 11
    gpu 20
    rom 48
  ]
  node [
    id 1
    label "1"
    cpu 24
    gpu 33
    rom 47
  ]
  node [
    id 2
    label "2"
    cpu 37
    gpu 26
    rom 7
  ]
  node [
    id 3
    label "3"
    cpu 6
    gpu 37
    rom 45
  ]
  node [
    id 4
    label "4"
    cpu 9
    gpu 8
    rom 14
  ]
  node [
    id 5
    label "5"
    cpu 30
    gpu 36
    rom 19
  ]
  node [
    id 6
    label "6"
    cpu 37
    gpu 8
    rom 10
  ]
  node [
    id 7
    label "7"
    cpu 48
    gpu 40
    rom 47
  ]
  node [
    id 8
    label "8"
    cpu 18
    gpu 50
    rom 19
  ]
  node [
    id 9
    label "9"
    cpu 4
    gpu 46
    rom 49
  ]
  node [
    id 10
    label "10"
    cpu 17
    gpu 34
    rom 1
  ]
  node [
    id 11
    label "11"
    cpu 44
    gpu 6
    rom 30
  ]
  node [
    id 12
    label "12"
    cpu 18
    gpu 50
    rom 6
  ]
  node [
    id 13
    label "13"
    cpu 27
    gpu 3
    rom 25
  ]
  node [
    id 14
    label "14"
    cpu 45
    gpu 10
    rom 28
  ]
  edge [
    source 0
    target 1
    bw 22
  ]
  edge [
    source 1
    target 2
    bw 45
  ]
  edge [
    source 2
    target 3
    bw 41
  ]
  edge [
    source 3
    target 4
    bw 19
  ]
  edge [
    source 4
    target 5
    bw 13
  ]
  edge [
    source 5
    target 6
    bw 25
  ]
  edge [
    source 6
    target 7
    bw 43
  ]
  edge [
    source 7
    target 8
    bw 29
  ]
  edge [
    source 8
    target 9
    bw 5
  ]
  edge [
    source 9
    target 10
    bw 42
  ]
  edge [
    source 10
    target 11
    bw 17
  ]
  edge [
    source 11
    target 12
    bw 30
  ]
  edge [
    source 12
    target 13
    bw 39
  ]
  edge [
    source 13
    target 14
    bw 47
  ]
]
