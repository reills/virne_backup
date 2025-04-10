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
  id 950
  arrival_time 20283.594534068558
  lifetime 3.646574758465774
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 24
    gpu 19
    rom 30
  ]
  node [
    id 1
    label "1"
    cpu 30
    gpu 4
    rom 29
  ]
  node [
    id 2
    label "2"
    cpu 8
    gpu 10
    rom 33
  ]
  node [
    id 3
    label "3"
    cpu 14
    gpu 18
    rom 40
  ]
  node [
    id 4
    label "4"
    cpu 37
    gpu 28
    rom 15
  ]
  node [
    id 5
    label "5"
    cpu 50
    gpu 48
    rom 39
  ]
  node [
    id 6
    label "6"
    cpu 32
    gpu 37
    rom 39
  ]
  node [
    id 7
    label "7"
    cpu 35
    gpu 34
    rom 20
  ]
  node [
    id 8
    label "8"
    cpu 16
    gpu 23
    rom 32
  ]
  node [
    id 9
    label "9"
    cpu 13
    gpu 30
    rom 11
  ]
  node [
    id 10
    label "10"
    cpu 34
    gpu 29
    rom 46
  ]
  node [
    id 11
    label "11"
    cpu 20
    gpu 49
    rom 33
  ]
  node [
    id 12
    label "12"
    cpu 25
    gpu 29
    rom 26
  ]
  edge [
    source 0
    target 1
    bw 7
  ]
  edge [
    source 1
    target 2
    bw 44
  ]
  edge [
    source 2
    target 3
    bw 4
  ]
  edge [
    source 3
    target 4
    bw 22
  ]
  edge [
    source 4
    target 5
    bw 47
  ]
  edge [
    source 5
    target 6
    bw 39
  ]
  edge [
    source 6
    target 7
    bw 47
  ]
  edge [
    source 7
    target 8
    bw 33
  ]
  edge [
    source 8
    target 9
    bw 7
  ]
  edge [
    source 9
    target 10
    bw 33
  ]
  edge [
    source 10
    target 11
    bw 0
  ]
  edge [
    source 11
    target 12
    bw 18
  ]
]
