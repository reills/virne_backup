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
  id 1994
  arrival_time 43498.068914588745
  lifetime 76.12291325242947
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 29
    gpu 2
    rom 28
  ]
  node [
    id 1
    label "1"
    cpu 50
    gpu 47
    rom 4
  ]
  node [
    id 2
    label "2"
    cpu 9
    gpu 27
    rom 39
  ]
  node [
    id 3
    label "3"
    cpu 35
    gpu 20
    rom 2
  ]
  node [
    id 4
    label "4"
    cpu 19
    gpu 28
    rom 24
  ]
  node [
    id 5
    label "5"
    cpu 43
    gpu 44
    rom 43
  ]
  node [
    id 6
    label "6"
    cpu 6
    gpu 4
    rom 21
  ]
  node [
    id 7
    label "7"
    cpu 25
    gpu 41
    rom 26
  ]
  node [
    id 8
    label "8"
    cpu 4
    gpu 17
    rom 42
  ]
  node [
    id 9
    label "9"
    cpu 38
    gpu 35
    rom 40
  ]
  node [
    id 10
    label "10"
    cpu 8
    gpu 46
    rom 11
  ]
  node [
    id 11
    label "11"
    cpu 37
    gpu 6
    rom 44
  ]
  node [
    id 12
    label "12"
    cpu 30
    gpu 26
    rom 3
  ]
  node [
    id 13
    label "13"
    cpu 28
    gpu 17
    rom 33
  ]
  edge [
    source 0
    target 1
    bw 42
  ]
  edge [
    source 1
    target 2
    bw 17
  ]
  edge [
    source 2
    target 3
    bw 38
  ]
  edge [
    source 3
    target 4
    bw 16
  ]
  edge [
    source 4
    target 5
    bw 17
  ]
  edge [
    source 5
    target 6
    bw 11
  ]
  edge [
    source 6
    target 7
    bw 37
  ]
  edge [
    source 7
    target 8
    bw 43
  ]
  edge [
    source 8
    target 9
    bw 5
  ]
  edge [
    source 9
    target 10
    bw 17
  ]
  edge [
    source 10
    target 11
    bw 0
  ]
  edge [
    source 11
    target 12
    bw 32
  ]
  edge [
    source 12
    target 13
    bw 15
  ]
]
