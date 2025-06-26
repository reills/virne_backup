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
  id 1045
  arrival_time 22093.40877288532
  lifetime 1010.9138409332892
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 31
    gpu 25
    rom 25
  ]
  node [
    id 1
    label "1"
    cpu 43
    gpu 50
    rom 14
  ]
  node [
    id 2
    label "2"
    cpu 47
    gpu 9
    rom 14
  ]
  node [
    id 3
    label "3"
    cpu 12
    gpu 34
    rom 28
  ]
  node [
    id 4
    label "4"
    cpu 39
    gpu 29
    rom 1
  ]
  node [
    id 5
    label "5"
    cpu 33
    gpu 30
    rom 34
  ]
  node [
    id 6
    label "6"
    cpu 37
    gpu 26
    rom 5
  ]
  node [
    id 7
    label "7"
    cpu 5
    gpu 0
    rom 6
  ]
  node [
    id 8
    label "8"
    cpu 24
    gpu 48
    rom 33
  ]
  node [
    id 9
    label "9"
    cpu 50
    gpu 29
    rom 5
  ]
  node [
    id 10
    label "10"
    cpu 3
    gpu 25
    rom 22
  ]
  node [
    id 11
    label "11"
    cpu 16
    gpu 46
    rom 18
  ]
  node [
    id 12
    label "12"
    cpu 18
    gpu 11
    rom 27
  ]
  node [
    id 13
    label "13"
    cpu 20
    gpu 32
    rom 9
  ]
  edge [
    source 0
    target 1
    bw 13
  ]
  edge [
    source 1
    target 2
    bw 25
  ]
  edge [
    source 2
    target 3
    bw 25
  ]
  edge [
    source 3
    target 4
    bw 14
  ]
  edge [
    source 4
    target 5
    bw 15
  ]
  edge [
    source 5
    target 6
    bw 41
  ]
  edge [
    source 6
    target 7
    bw 14
  ]
  edge [
    source 7
    target 8
    bw 43
  ]
  edge [
    source 8
    target 9
    bw 34
  ]
  edge [
    source 9
    target 10
    bw 47
  ]
  edge [
    source 10
    target 11
    bw 24
  ]
  edge [
    source 11
    target 12
    bw 40
  ]
  edge [
    source 12
    target 13
    bw 30
  ]
]
