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
  id 1017
  arrival_time 21641.819452806925
  lifetime 25.89264696377196
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 38
    gpu 15
    rom 35
  ]
  node [
    id 1
    label "1"
    cpu 49
    gpu 12
    rom 47
  ]
  node [
    id 2
    label "2"
    cpu 35
    gpu 4
    rom 8
  ]
  node [
    id 3
    label "3"
    cpu 5
    gpu 28
    rom 19
  ]
  node [
    id 4
    label "4"
    cpu 15
    gpu 31
    rom 29
  ]
  node [
    id 5
    label "5"
    cpu 30
    gpu 37
    rom 1
  ]
  node [
    id 6
    label "6"
    cpu 18
    gpu 37
    rom 28
  ]
  node [
    id 7
    label "7"
    cpu 17
    gpu 45
    rom 9
  ]
  node [
    id 8
    label "8"
    cpu 27
    gpu 11
    rom 19
  ]
  node [
    id 9
    label "9"
    cpu 34
    gpu 15
    rom 42
  ]
  node [
    id 10
    label "10"
    cpu 5
    gpu 2
    rom 4
  ]
  node [
    id 11
    label "11"
    cpu 3
    gpu 20
    rom 11
  ]
  node [
    id 12
    label "12"
    cpu 45
    gpu 50
    rom 19
  ]
  node [
    id 13
    label "13"
    cpu 12
    gpu 4
    rom 39
  ]
  node [
    id 14
    label "14"
    cpu 9
    gpu 15
    rom 21
  ]
  edge [
    source 0
    target 1
    bw 20
  ]
  edge [
    source 1
    target 2
    bw 26
  ]
  edge [
    source 2
    target 3
    bw 18
  ]
  edge [
    source 3
    target 4
    bw 7
  ]
  edge [
    source 4
    target 5
    bw 37
  ]
  edge [
    source 5
    target 6
    bw 12
  ]
  edge [
    source 6
    target 7
    bw 0
  ]
  edge [
    source 7
    target 8
    bw 26
  ]
  edge [
    source 8
    target 9
    bw 1
  ]
  edge [
    source 9
    target 10
    bw 11
  ]
  edge [
    source 10
    target 11
    bw 15
  ]
  edge [
    source 11
    target 12
    bw 31
  ]
  edge [
    source 12
    target 13
    bw 6
  ]
  edge [
    source 13
    target 14
    bw 3
  ]
]
