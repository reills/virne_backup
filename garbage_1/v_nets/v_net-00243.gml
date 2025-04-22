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
  id 243
  arrival_time 4541.157017121688
  lifetime 134.58955117075888
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 7
    gpu 34
    rom 20
  ]
  node [
    id 1
    label "1"
    cpu 38
    gpu 21
    rom 19
  ]
  node [
    id 2
    label "2"
    cpu 32
    gpu 38
    rom 6
  ]
  node [
    id 3
    label "3"
    cpu 38
    gpu 39
    rom 21
  ]
  node [
    id 4
    label "4"
    cpu 34
    gpu 4
    rom 48
  ]
  node [
    id 5
    label "5"
    cpu 28
    gpu 17
    rom 13
  ]
  node [
    id 6
    label "6"
    cpu 31
    gpu 1
    rom 27
  ]
  node [
    id 7
    label "7"
    cpu 22
    gpu 3
    rom 0
  ]
  node [
    id 8
    label "8"
    cpu 23
    gpu 25
    rom 22
  ]
  node [
    id 9
    label "9"
    cpu 17
    gpu 15
    rom 28
  ]
  node [
    id 10
    label "10"
    cpu 28
    gpu 6
    rom 45
  ]
  node [
    id 11
    label "11"
    cpu 33
    gpu 9
    rom 26
  ]
  node [
    id 12
    label "12"
    cpu 39
    gpu 39
    rom 17
  ]
  node [
    id 13
    label "13"
    cpu 46
    gpu 32
    rom 49
  ]
  edge [
    source 0
    target 1
    bw 36
  ]
  edge [
    source 1
    target 2
    bw 41
  ]
  edge [
    source 2
    target 3
    bw 27
  ]
  edge [
    source 3
    target 4
    bw 12
  ]
  edge [
    source 4
    target 5
    bw 24
  ]
  edge [
    source 5
    target 6
    bw 15
  ]
  edge [
    source 6
    target 7
    bw 8
  ]
  edge [
    source 7
    target 8
    bw 9
  ]
  edge [
    source 8
    target 9
    bw 5
  ]
  edge [
    source 9
    target 10
    bw 24
  ]
  edge [
    source 10
    target 11
    bw 38
  ]
  edge [
    source 11
    target 12
    bw 12
  ]
  edge [
    source 12
    target 13
    bw 37
  ]
]
