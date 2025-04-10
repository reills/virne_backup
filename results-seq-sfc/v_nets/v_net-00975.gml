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
  id 975
  arrival_time 20844.188964149154
  lifetime 9.581171563834399
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 6
    gpu 46
    rom 50
  ]
  node [
    id 1
    label "1"
    cpu 29
    gpu 27
    rom 16
  ]
  node [
    id 2
    label "2"
    cpu 15
    gpu 13
    rom 16
  ]
  node [
    id 3
    label "3"
    cpu 29
    gpu 22
    rom 3
  ]
  node [
    id 4
    label "4"
    cpu 49
    gpu 4
    rom 44
  ]
  node [
    id 5
    label "5"
    cpu 46
    gpu 20
    rom 0
  ]
  node [
    id 6
    label "6"
    cpu 41
    gpu 2
    rom 7
  ]
  node [
    id 7
    label "7"
    cpu 33
    gpu 19
    rom 18
  ]
  node [
    id 8
    label "8"
    cpu 46
    gpu 45
    rom 27
  ]
  node [
    id 9
    label "9"
    cpu 37
    gpu 46
    rom 44
  ]
  node [
    id 10
    label "10"
    cpu 2
    gpu 7
    rom 31
  ]
  node [
    id 11
    label "11"
    cpu 19
    gpu 2
    rom 22
  ]
  node [
    id 12
    label "12"
    cpu 40
    gpu 43
    rom 24
  ]
  edge [
    source 0
    target 1
    bw 35
  ]
  edge [
    source 1
    target 2
    bw 39
  ]
  edge [
    source 2
    target 3
    bw 0
  ]
  edge [
    source 3
    target 4
    bw 9
  ]
  edge [
    source 4
    target 5
    bw 33
  ]
  edge [
    source 5
    target 6
    bw 26
  ]
  edge [
    source 6
    target 7
    bw 50
  ]
  edge [
    source 7
    target 8
    bw 28
  ]
  edge [
    source 8
    target 9
    bw 28
  ]
  edge [
    source 9
    target 10
    bw 20
  ]
  edge [
    source 10
    target 11
    bw 30
  ]
  edge [
    source 11
    target 12
    bw 18
  ]
]
